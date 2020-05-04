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

PI = pi(1000)

puts( "                                    value      delta  value-Math::PI" )
puts( "-----------------------------------------  ---------  ---------" )
pis = (1..500).map{ |e|
  #Nabetani.rationalize(PI, 0.5**(e/2))
  PI.rationalize((0.5**(e/4.0)).to_r)
}.uniq

pis.each do |pi|
  real_delta = (pi-PI).to_f
  delta_d = (pi-Math::PI.to_r).to_f
  s = "%d / %d" % [ pi.numerator, pi.denominator ]
  puts( "%41s  %+.2e  %+.2e" % [ s, real_delta, delta_d ] )
end


g=pis.map{ |pi|
  [Math.log10((pi-PI).to_f.abs) + Math.log10(pi.numerator*pi.denominator), pi]
}.sort.take(5)

puts( "|#|値|誤差|log10(誤差)+log10(分母×分子)|")
puts( "|--:|--:|:--:|:--|")

g.each.with_index(1) do |(d,pi),ix|
  puts( "|%d|%s|%+.2e|%.3f|" % [ ix, pi, (pi-PI).to_f, d] )
end
