images_trainset = loadMNISTImages('E:\��һ�̲ļ��ο��鼮\ģʽʶ��\MNIST_of_handwritten_digits\train-images.idx3-ubyte');
labels_trainset = loadMNISTLabels('E:\��һ�̲ļ��ο��鼮\ģʽʶ��\MNIST_of_handwritten_digits\train-labels.idx1-ubyte');
tic;
[sortedData,numImages,index ] = sortMyTrainset( images_trainset, labels_trainset );
t2 = toc;
