function mark_cross(r)
    for side in (Nord, West, Sud, Ost)
        num_steps = putmarkers!(r,side)
        movements!(r,inverse(side), num_steps)
    end
end

function move_if_possible!(r::Robot, side::HorizonSide)::Bool #функция похожа на ту, которую вы показывали на одной из лекций
    right_side = right(side)
    reverse_side = inverse(right_side)
    num_steps=0
    while isborder(r,side) == true
        if isborder(r, right_side) == false
            move!(r,right_side)
            num_steps += 1
        else
            break
        end
    end
    if isborder(r,side) == false
        while isborder(r,side) == false
            move!(r,side)
        end
        result = true
    else
        result = false
    end
    move!(r,reverse_side)
    return result
end

movements!(r::Robot, side::HorizonSide, num_steps::Int) =
for _ in 1:num_steps
    move_if_possible!(r,side)
end

right(side::HorizonSide) = HorizonSide(mod(Int(side)+1,4))
