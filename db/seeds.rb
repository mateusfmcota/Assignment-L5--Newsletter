10.times do
  Email.create(subject: Faker::Educator.course_name, body: Faker::Lorem.paragraph(sentence_count: 30))
end
