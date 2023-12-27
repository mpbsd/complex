local complex = {}

complex.number = function(re, im)
  return { ["re"] = re, ["im"] = im }
end

complex["0"] = complex.number(0, 0)
complex["1"] = complex.number(1, 0)
complex["i"] = complex.number(0, 1)

complex.isequalto = function(c1, c2)
  return (c1.re == c2.re) and (c1.im == c2.im)
end

complex.conjugate = function(c)
  return complex.number(c.re, -c.im)
end

complex.realinnerproduct = function(c1, c2)
  return c1.re * c2.re + c1.im * c2.im
end

complex.modulus = function(c)
  return complex.realinnerproduct(c, complex.conjugate(c)) ^ 0.5
end

complex.add = function(c1, c2)
  return complex.number(c1.re + c2.re, c1.im + c2.im)
end

complex.subtract = function(c1, c2)
  return complex.number(c1.re - c2.re, c1.im - c2.im)
end

complex.multiply = function(c1, c2)
  local re = c1.re * c2.re - c1.im * c2.im
  local im = c1.re * c2.im + c1.im * c2.re
  return complex.number(re, im)
end

complex.inverse = function(c)
  local inverse
  if not complex.isequalto(c) then
    local c1 = complex.conjugate(c)
    local c2 = complex.number(complex.modulus(c) ^ -2, 0)
    inverse = complex.multiply(c1, c2)
  end
  return inverse
end

complex.divide = function(c1, c2)
  local res
  if not complex.isequalto(c2, complex["0"]) then
    res = complex.multiply(c1, complex.inverse(c2))
  end
  return res
end

return complex
