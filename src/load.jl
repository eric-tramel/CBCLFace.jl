using Images

function loadDataFromFiles!(fileDir,fileList,Dataset;hist_eq=false)
  for sampleIdx = 1:size(Dataset,2)
    imFile = joinpath(fileDir,fileList[sampleIdx])
    im = load(imFile)
    ImgData = convert(Array{Float64,2},im.data)
    if hist_eq
      ImgData = histogramEqualization(ImgData)
    end
    Dataset[:,sampleIdx] = ImgData[:]
  end
end


function histogramEqualization(im)
  # println("=================EQ====================")
  L  = 256   # Intesnity levels
  Lm = 255   # L-1
  N = length(im)
  inc = 1./N;
  
  # First, convert everything back to integers [0,255]
  im = floor(im.*255.0)
  # println(im)
  UIim = convert(Array{UInt8,2},im)

  # Next, we want the PMF
  P = zeros(L,1)
  for i=1:N
    P[UIim[i]+1] += inc;
  end

  gim = copy(im)
  # Now apply equalizaitons
  for i=1:N
    gim[i] = Lm.*sum(P[1:(UIim[i]+1)])
  end

  return gim
end



function traindata(;hist_eq=false)
  Pixels  = 19*19
    
  # Load Face Data
  FaceDataDir = joinpath(dirname(@__FILE__),"..","data","train","face")
  FaceFiles   = readdir(FaceDataDir)
  FaceDataset = Array(Float64,Pixels,length(FaceFiles))
  loadDataFromFiles!(FaceDataDir,FaceFiles,FaceDataset;hist_eq=hist_eq)

  # Load Non-Face Data  
  NonFaceDataDir = joinpath(dirname(@__FILE__),"..","data","train","non-face")
  NonFaceFiles = readdir(NonFaceDataDir)
  NonFaceDataset = Array(Float64,Pixels,length(NonFaceFiles))
  loadDataFromFiles!(NonFaceDataDir,NonFaceFiles,NonFaceDataset;hist_eq=hist_eq)
  
  return FaceDataset, NonFaceDataset
end

function testdata(;hist_eq=false)
  Pixels  = 19*19
    
  # Load Face Data
  FaceDataDir = joinpath(dirname(@__FILE__),"..","data","test","face")
  FaceFiles   = readdir(FaceDataDir)
  FaceDataset = Array(Float64,Pixels,length(FaceFiles))
  loadDataFromFiles!(FaceDataDir,FaceFiles,FaceDataset;hist_eq=hist_eq)

  # Load Non-Face Data  
  NonFaceDataDir = joinpath(dirname(@__FILE__),"..","data","test","non-face")
  NonFaceFiles = readdir(NonFaceDataDir)
  NonFaceDataset = Array(Float64,Pixels,length(NonFaceFiles))
  loadDataFromFiles!(NonFaceDataDir,NonFaceFiles,NonFaceDataset;hist_eq=hist_eq)
  
  return FaceDataset, NonFaceDataset
end