# abstract type SUSY end

struct SUSY 
    N ::Integer
    NumberOfAxillaryFields ::Integer

    SUSY(N, A) = new(N, A)

    # Fix the definitions of function so we just give them an instant of SUSY.
    NumberOfFields(N::Integer) = 2*N
    NumberOfVar(N::Integer, NumberOfAxillaryFields::Integer) = NumberOfAxillaryFields*NumberOfFields(N)^2
end

function Populate_LR(S::SUSY)

    NumberOfFields = S.NumberOfFields(S.N)
    NumberOfVar = S.NumberOfVar(S.N, S.NumberOfAxillaryFields)
    
    @variables l[1:NumberOfVar], r[1:NumberOfVar]

    OnShell_L = [[[1, 0, 0, 0] [0, 0, 0, -1]], [[0, 1, 0, 0] [0, 0, 1, 0]], [[0, 0, 1, 0] [0, -1, 0, 0]], [[0, 0, 0, 1] [1, 0, 0, 0]]]
    OnShell_R = [[[1, 0, 0, 0] [0, 0, 0, -1]], [[0, 1, 0, 0] [0, 0, 1, 0]], [[0, 0, 1, 0] [0, -1, 0, 0]], [[0, 0, 0, 1] [1, 0, 0, 0]]]

    L = Array{Matrix}(undef, NumberOfFields) 
    for i in 1:NumberOfFields
        L[i] = transpose(hcat(OnShell_L[i], reshape(l, NumberOfFields, S.NumberOfAxillaryFields*NumberOfFields)[:,((i-1)*S.NumberOfAxillaryFields+1):(i*S.NumberOfAxillaryFields)]))
    end

    R = Array{Matrix}(undef, NumberOfFields) 
    for i in 1:NumberOfFields
        R[i] = hcat(OnShell_R[i], reshape(r, NumberOfFields, S.NumberOfAxillaryFields*NumberOfFields)[:,((i-1)*S.NumberOfAxillaryFields+1):(i*S.NumberOfAxillaryFields)])
    end

    return L, R
end

function Populate_LR(S::SUSY, OnShell_L, OnShell_R)

    NumberOfFields = S.NumberOfFields(S.N)
    NumberOfVar = S.NumberOfVar(S.N, S.NumberOfAxillaryFields)
    
    @variables l[1:NumberOfVar], r[1:NumberOfVar]

    L = Array{Matrix}(undef, NumberOfFields) 
    for i in 1:NumberOfFields
        L[i] = transpose(hcat(OnShell_L[i], reshape(l, NumberOfFields, S.NumberOfAxillaryFields*NumberOfFields)[:,((i-1)*S.NumberOfAxillaryFields+1):(i*S.NumberOfAxillaryFields)]))
    end

    R = Array{Matrix}(undef, NumberOfFields) 
    for i in 1:NumberOfFields
        R[i] = hcat(OnShell_R[i], reshape(r, NumberOfFields, S.NumberOfAxillaryFields*NumberOfFields)[:,((i-1)*S.NumberOfAxillaryFields+1):(i*S.NumberOfAxillaryFields)])
    end

    return L, R
end