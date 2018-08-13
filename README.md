# linreg

Hardware-accelerated vectorized gradient descent for linear regression.

## Architecture

To speed up linear regression one can leverage the inherent parallelism in matrix multiplication which custom hardware can effectively do in parallel.

Our design uses Xilinx's MicroBlaze processor (to control the flow of the gradient descent algorithm) and a custom IP Core (to compute the parameter updates) interfaced by AXI Stream.

![](https://i.imgur.com/IPszi4A.png)

### Custom IP Core

Our custom IP core is a coprocessor in the true sense of the word because the MicroBlaze processor sends it instructions according to an instruction set.

The coprocessor receives, decodes and processes these instructions on its slave interface. The result (a vector of elements) is buffered to the MicroBlaze processor one element (a 32 bit word) at a time.

This results in a fairly clean, stateless implementation of the coprocessor's slave interface.

### MicroBlaze processor

The MicroBlaze processor sends the coprocessor instructions (according to the instruction set) to store each element of the matrix X, vector Y, learning rate α, and parameters θ. After this, in a loop, it instructs the coprocessor to run iterations of gradient descent.

The software running on the MicroBlaze processor checks if the algorithm has converged on every iteration. A useful (but not totally accurate) approximation to declare convergence is: when the difference between the updated θ vector and the previous θ vector is below a certain threshold, then the algorithm has converged, otherwise, it hasn’t.

## Timing Performance

A fixed interval timer is configured to fire events every 100000-th clock cycle. The MicroBlaze processor is interrupted on each one of these events, upon which an interrupt handler is called to increment a global counter `irqCount`.

We can reset this counter when we want to start timing some task and simply look at the counter when we know said task has finished.

We can estimate the time elapsed `T` as a function of the interrupt counter `irqCount`, the clock’s period `period` and the frequency of the fixed interval timer `fit`.

```
T = period × irqCount × fit
```

## Results

On a small dataset we observed 8x speedup in performance relative to a pure software implementation running on the MicroBlaze processor alone. On larger datasets it is expected that this difference is more significant.

However, there is still room for improvement. Rather than computing the gradient over all the samples of the dataset, one could compute the gradient for every k-subsample of the dataset in parallel and combine them together, effectively doing what is called map-reduce batch gradient descent.
