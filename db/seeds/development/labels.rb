0.upto(9) do |idx|
  Label.create(
    labelname: test#{idx + 1}
  )
end 