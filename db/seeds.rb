User.create!(name: 'admin', email: 'admin@example.com', password: '111111', password_confirmation: '111111', admin: true)

names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)

0.upto(9) do |idx|
  User.create!(
    name: names[idx],
    email: "#{names[idx]}@example.com",
    password: "111111",
    password_confirmation: "111111",
    admin: false
  )
end

number = 0

User.all.each do |user|
  0.upto(3) do
    number += 1
    Task.create!(
      title: 'seedtesttasktitle1_' + number.to_s, 
      content: 'seedtesttaskcontent1_' + number.to_s, 
      end_date: '002023/01/13',
      start_status: "未着手",
      priority: "低",
      user_id: user.id
    )
  end
end
number = 0
User.all.each do |user|
  0.upto(2) do
    number += 1
    Task.create!(
      title: 'seedtesttasktitle2_' + number.to_s, 
      content: 'seedtesttaskcontent2_' + number.to_s, 
      end_date: '002023/01/14',
      start_status: "着手",
      priority: "中",
      user_id: user.id
    )
  end
end
number = 0
User.all.each do |user|
  0.upto(2) do
    number += 1
    Task.create!(
      title: 'seedtesttasktitle3_' + number.to_s, 
      content: 'seedtesttaskcontent3_' + number.to_s, 
      end_date: '002023/01/15',
      start_status: "完了",
      priority: "高",
      user_id: user.id
    )
  end
end

labels = %w( supper picket subset lender stance labour gopher travel relief squash)

0.upto(9) do |idx|
  Label.create!(
    name: labels[idx]
  )
end
