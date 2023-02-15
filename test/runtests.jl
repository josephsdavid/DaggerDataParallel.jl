using DaggerDataParallel
using Dagger
using Distributed
using Flux
using Random
using Test
using Pkg

project = DaggerDataParallel.PROJECT
@show project
pids = addprocs(4)

# https://engineering.fb.com/2021/07/15/open-source/fsdp/
# https://tech.preferred.jp/en/blog/technologies-behind-distributed-deep-learning-allreduce/

# gather

const PID = 1

@testset "ddp" begin
    promises = map(pids) do pid
        return @async begin
            Distributed.remotecall_eval(Main, pid,
                                        :(using Pkg;
                                          Pkg.activate($(project));
                                          Pkg.instantiate()))
            Distributed.remotecall_eval(Main, pid,
                                        :(using DaggerDataParallel, Distributed, Flux,
                                                Dagger))
            Distributed.remotecall_eval(Main, pid, :(const PID = $(pid)))
        end
    end

    map(fetch, promises)


    @everywhere begin
        function cycler(pid)
            ran = false
            output = []
            function cycle(pid)
                ran == false && return pid - 1 # TODO: Actually grab the number
                ret
            end
        end
    end

    tasks = map(1:6) do _
        Dagger.@spawn (() -> PID)()
    end
    @show fetch.(tasks)

    tasks = map(1:6) do _
        Dagger.@spawn()

    end

end

rmprocs(pids)
