names = %w(sato suzuki tanaka takahashi ito watanabe yamamoto nakamura kobayashi kato)

0.upto(9) do |idx|
  User.create(
    name: names[idx],
    email: "#{names[idx]}@example.com",
    password: 'password',
    admin: true
  )
ends