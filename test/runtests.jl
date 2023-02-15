using DaggerDataParallel
using Distributed
using Flux
using Test
using Pkg

project = Pkg.project().path
pids = addprocs(4)

# https://engineering.fb.com/2021/07/15/open-source/fsdp/
# https://tech.preferred.jp/en/blog/technologies-behind-distributed-deep-learning-allreduce/

# gather


@testset "ddp" begin

    map(pids) do pid
        return @async begin
            Distributed.remotecall_eval.(Main, pids,
                                         :(using Pkg; Pkg.activate($(project)); Pkg.instantiate()))
            Distributed.remotecall_eval.(Main, pids,
                                         :(using DaggerDataParallel, Distributed, Flux))
        end
    end

    @every

end

rmprocs(pids)
