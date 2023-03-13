0.upto(9) do |idx|
  Task.create(
    title: "test#{idx + 1}",
    content: "test#{idx +1}_content",
    deadline: "2023/03/25",
    status: '未着手',
    priority: '中',
    user_id: "1"
  )
end