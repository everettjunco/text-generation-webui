from setuptools import setup, Extension
from torch.utils import cpp_extension
import torch
import os

def is_available():
    if not hasattr(torch._C, "_cuda_isDriverSufficient"):
        return False
    return torch._C._cuda_isDriverSufficient()

if is_available():
    arch_list = os.environ.get("TORCH_CUDA_ARCH_LIST", None)
    if arch_list:
        arch_list = [arch.strip() for arch in arch_list.split(";")]
        arch_list[-1] += "+PTX"

setup(
    name="quant_cuda",
    ext_modules=[cpp_extension.CUDAExtension(
        "quant_cuda", ["quant_cuda.cpp", "quant_cuda_kernel.cu"]
    )],
    cmdclass={"build_ext": cpp_extension.BuildExtension}
)
