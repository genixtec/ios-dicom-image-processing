# ios-dicom-image-processing

DICOM image processing using Imebra

[Imebra Offical Guide](https://imebra.com/wp-content/uploads/documentation/html/quick_tour.html)

## Prerequisite
  * [Download Imebra 4.2](https://imebra.com/get-it/)
  * [Download Cmake](https://cmake.org/download/)

## ImebraBuild Setup

As per the Imebra official guide compile and generate library using command line as follows,

##### For iOS

```
mkdir imebra_for_ios
cd imebra_for_ios
cmake your_imebra_location -DIOS=IPHONE
cmake --build .
```
##### For iOS-Simulator

```
mkdir imebra_for_ios_simulator
cd imebra_for_ios_simulator
cmake your_imebra_location -DIOS=SIMULATOR
cmake --build .
```

In both compilation, libimebra.a will be generated.

##### Combine Static Libraries

lipo -create libimebra.a libimebra.a -o libimebraUniversal.a

> Note: libimebra.a one is iPhone(armv7,armv7s architecture) and another one for simulator(i386,x86_64 architecture).
Rename libimebraUniversal.a to libimebra.a

## Xcode Setup

* Select Target -> Build Phase -> Link Binary with libraries -> Click "+" to add the libraries libimebra.a, libiconv.tbd and libc++.tbd

* Select Target -> Build Settings -> Search Paths -> Library Search Paths -> add Imebra build location (imebra_for_ios or imebra_for_ios_simulator) with recursive

That's it Clean and Build.
