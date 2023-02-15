module DaggerDataParallel

using Dagger
using Distributed
using Flux

# TODO:
# 1. Get an example model
# 2. Sample data
# 4. Make some API (do we need to using flux if we just have to model update
# 3. Spawn some threads


function parallel_batch(model, gradient_function, data, batch_size)
    # NOTE: For now just simple data
    # Take in the model
    # Shard the data
    # function which returns the gradients (maybe api expectations?)
    # for each shard of data, calc gradients on a separate thread
    # get all the gradients
    # use something like how it is done in seizurelab
    # do something with them
    # TODO: Tests that the result is the same
end
end # module DaggerDataParallel
