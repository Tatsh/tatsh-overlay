# Report CUDA out-of-memory as a skip: many parametrised cases are sized for
# 80 GB cards and cannot run on smaller GPUs.
import pytest
import torch


@pytest.hookimpl(wrapper=True)
def pytest_runtest_call(item):
    try:
        return (yield)
    except torch.OutOfMemoryError as e:
        torch.cuda.empty_cache()
        pytest.skip(f'needs more GPU memory: {str(e).splitlines()[0]}')
