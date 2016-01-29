# File Names 
DataDir = joinpath(dirname(@__FILE__),"..","data")
CompressFile = joinpath(DataDir,"bindata.tar.gz")
CifarOrigDir = joinpath(DataDir,"cifar-10-batches-bin")
CifarFinalDir = joinpath(DataDir,"bin")

# Download Compressed Files
download("http://cbcl.mit.edu/projects/cbcl/software-datasets/faces.tar.gz",CompressFile)

# # Decompress Dataset
cd(DataDir)
run(`tar -zxvf $CompressFile`)
run(`tar -zxvf face.test.tar.gz`)
run(`tar -zxvf face.train.tar.gz`)