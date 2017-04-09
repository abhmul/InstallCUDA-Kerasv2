"""This script goes along the blog post
"Building powerful image classification models using very little data"
from blog.keras.io.
It uses data that can be downloaded at:
https://www.kaggle.com/c/dogs-vs-cats/data
In our setup, we:
- created a data/ folder
- created train/ and validation/ subfolders inside data/
- created cats/ and dogs/ subfolders inside train/ and validation/
- put the cat pictures index 0-999 in data/train/cats
- put the cat pictures index 1000-1400 in data/validation/cats
- put the dogs pictures index 12500-13499 in data/train/dogs
- put the dog pictures index 13500-13900 in data/validation/dogs
So that we have 1000 training examples for each class, and 400 validation examples for each class.
In summary, this is our directory structure:
```
data/
    train/
        dogs/
            dog001.jpg
            dog002.jpg
            ...
        cats/
            cat001.jpg
            cat002.jpg
            ...
    validation/
        dogs/
            dog001.jpg
            dog002.jpg
            ...
        cats/
            cat001.jpg
            cat002.jpg
            ...
```
"""
from keras.preprocessing.image import ImageDataGenerator
from keras.models import Model
from keras.layers import Convolution2D, MaxPooling2D
from keras.layers import Activation, Dropout, Flatten, Dense, GlobalAveragePooling2D
from keras.applications.inception_v3 import InceptionV3
from keras.callbacks import ModelCheckpoint
from keras.optimizers import SGD


# dimensions of our images.
img_width, img_height = 299, 299

train_data_dir = 'CatDogDataset/train'
validation_data_dir = 'CatDogDataset/validation'
nb_train_samples = 2000
nb_validation_samples = 800
nb_epoch = 10


# create the base pre-trained model
base_model = InceptionV3(weights='imagenet', include_top=False)

# add a global spatial average pooling layer
x = base_model.output
x = GlobalAveragePooling2D()(x)
x = Dense(64)(x)
x = Activation('relu')(x)
x = Dropout(0.5)(x)
x = Dense(1)(x)
predictions = Activation('sigmoid')(x)

# this is the model we will train
model = Model(inputs=base_model.input, outputs=predictions)

optimizer=SGD(lr=0.0001, momentum=0.9)

model.compile(loss='binary_crossentropy',
              optimizer=optimizer,
              metrics=['accuracy'])

# this is the augmentation configuration we will use for training
train_datagen = ImageDataGenerator(
        rescale=1./255,
        shear_range=0.2,
        zoom_range=0.2,
        horizontal_flip=True)

# this is the augmentation configuration we will use for testing:
# only rescaling
test_datagen = ImageDataGenerator(rescale=1./255)

train_generator = train_datagen.flow_from_directory(
        train_data_dir,
        target_size=(img_width, img_height),
        batch_size=32,
        class_mode='binary')

validation_generator = test_datagen.flow_from_directory(
        validation_data_dir,
        target_size=(img_width, img_height),
        batch_size=32,
        class_mode='binary')

# This will save the best scoring model weights to the current directory
best_model_file = 'data_aug2_weights.h5'
best_model = ModelCheckpoint(best_model_file, monitor='val_acc', mode='max',
                             verbose=1, save_best_only=True,
                             save_weights_only=True)

model.fit_generator(
        train_generator,
        steps_per_epoch=int((nb_train_samples + 31) / 32),
        epochs=nb_epoch,
        validation_data=validation_generator,
        validation_steps=int((nb_validation_samples + 31) / 32),
        callbacks=[best_model])
