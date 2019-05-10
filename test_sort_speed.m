images_trainset = loadMNISTImages('E:\研一教材及参考书籍\模式识别\MNIST_of_handwritten_digits\train-images.idx3-ubyte');
labels_trainset = loadMNISTLabels('E:\研一教材及参考书籍\模式识别\MNIST_of_handwritten_digits\train-labels.idx1-ubyte');
tic;
[sortedData,numImages,index ] = sortMyTrainset( images_trainset, labels_trainset );
t2 = toc;
