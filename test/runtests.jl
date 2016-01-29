using CBCLFace
using Base.Test
using PyCall
@pyimport matplotlib.pyplot as plt

# write your own tests here
println("Running Tests...")

FD, NFD = traindata(hist_eq=true)


for i=1:20
  plt.imshow(reshape(FD[:,i],(19,19))';interpolation="nearest")
  plt.colorbar()
  plt.gray()
  plt.show(block=true)
end


for i=1:20
  plt.imshow(reshape(FD[:,i],(19,19))';interpolation="nearest")
  plt.colorbar()
  plt.gray()
  plt.show(block=true)
end