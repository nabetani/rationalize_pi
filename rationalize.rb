def fb(n)
  # formula(2) in https://bellard.org/pi/pi_bin.pdf
  n = n.to_r
  [
    4r/(8r*n+1),
    -2r/(8r*n+4),
    -1r/(8r*n+5),
    -1r/(8r*n+6),
  ].sum * 1r/(16r**n)
end

def pi(n)
  (0..n).sum{|e| fb(e) }
end

PI = pi(400)

p (PI-Math::PI.to_r).to_f

(1..200).map{ |e|
  PI.rationalize(0.5**(e/2))
}.uniq.each do |pi|
  real_delta = (pi-PI).to_f
  delta_d = (pi-Math::PI.to_r).to_f
  s = "%d/%d" % [ pi.numerator, pi.denominator ]
  puts( "%17s  %8e  %8e" % [ s, real_delta, delta_d ] )
end

