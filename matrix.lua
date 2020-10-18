vec3 = require('lib/vec3')

function createMatrix(vx, vy, vz)
    local matrix = {
        { vx.x, vx.y, vx.z },
        { vy.x, vy.y, vy.z },
        { vz.x, vz.y, vz.z }
    }
    return matrix
end



function matrixToString(mat)
    return string.format("[%+0.3f,%+0.3f,%+0.3f]\n[%+0.3f,%+0.3f,%+0.3f]\n[%+0.3f,%+0.3f,%+0.3f]\n", 
        mat[1][1], mat[1][2], mat[1][3],
        mat[2][1], mat[2][2], mat[2][3],
        mat[3][1], mat[3][2], mat[3][3])
end

function getDeterminant(v1, v2, v3, v4)
    return v1 * v4 - v2 * v3
end

function matrixTranspose(mat)
    local mt = {{}, {}, {}}
    
    for r=1,3 do
        for c=1,3 do
            mt[r][c] = mat[c][r]
        end
    end
    return mt
end

function matrixXScalar(mat, s)
    local mt = {{}, {}, {}}
    
    for r=1,3 do
        for c=1,3 do
            mt[r][c] = mat[r][c] * s
        end
    end
    return mt
end

function matrixInvert(mat)
    local m1 = {{}, {}, {}}
    m1[1][1] = getDeterminant(mat[2][2], mat[2][3], mat[3][2], mat[3][3])
    m1[1][2] = -getDeterminant(mat[2][1], mat[2][3], mat[3][1], mat[3][3])
    m1[1][3] = getDeterminant(mat[2][1], mat[2][2], mat[3][1], mat[3][2])

    m1[2][1] = -getDeterminant(mat[1][2], mat[1][3], mat[3][2], mat[3][3])
    m1[2][2] = getDeterminant(mat[1][1], mat[1][3], mat[3][1], mat[3][3])
    m1[2][3] = -getDeterminant(mat[1][1], mat[1][2], mat[3][1], mat[3][2])

    m1[3][1] = getDeterminant(mat[1][2], mat[1][3], mat[2][2], mat[2][3])
    m1[3][2] = -getDeterminant(mat[1][1], mat[1][3], mat[2][1], mat[2][3])
    m1[3][3] = getDeterminant(mat[1][1], mat[1][2], mat[2][1], mat[2][2])
    
    local det1 = mat[1][1] * m1[1][1] + mat[1][2] * m1[1][2] + mat[1][3] * m1[1][3]

    return matrixXScalar(matrixTranspose(m1), 1 / det1)
end

function matrixXMatrix(m1, m2)
    local mt = {{}, {}, {}}

    for r=1,3 do
        for c=1,3 do
            mt[r][c] = m1[r][1] * m2[1][c] + m1[r][2] * m2[2][c] + m1[r][3] * m2[3][c]
        end
    end
    return mt
end

function matrixXVec(mat, vec) 
    local x = mat[1][1] * vec.x + mat[2][1] * vec.y + mat[3][1] * vec.z
    local y = mat[1][2] * vec.x + mat[2][2] * vec.y + mat[3][2] * vec.z
    local z = mat[1][3] * vec.x + mat[2][3] * vec.y + mat[3][3] * vec.z
    return vec3(x, y, z)
end

mat = createMatrix(vec3(2, 3, 2), vec3(10, 9, 29), vec3(-2, 30, 4))
matInv = matrixInvert(mat)
matRes = matrixXMatrix(mat, matInv)
print(matrixToString(matRes))

print(matrixXVec(matInv, vec3(-10, -9, -29)))