# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


puts "Cleaning the db.."
Task.destroy_all
Match.destroy_all
Goal.destroy_all
User.destroy_all

puts "Creating sample data..."

categories = {
  'Productivity and Time Management' => {
    'Task Management' => 'Efficiently manage tasks and prioritize activities to optimize productivity.',
    'Prioritization' => 'Identify and prioritize tasks based on importance and urgency to maximize efficiency.',
    'Time Blocking' => 'Allocate specific time slots for different tasks or activities to better manage time.',
    'Pomodoro Technique' => 'Use the Pomodoro Technique to break work into intervals, typically 25 minutes, separated by short breaks.',
    'Goal Setting' => 'Set clear and achievable goals to stay focused and motivated in accomplishing tasks.'
  },
  'Skill Development' => {
    'Programming and Coding' => 'Learn programming languages and coding skills to build software applications and websites.',
    'Graphic Design' => 'Develop skills in graphic design, including creating visual content and digital illustrations.',
    'Language Learning' => 'Master new languages through study, practice, and immersion to communicate effectively.',
    'Music Instrument' => 'Learn to play musical instruments and develop musical skills for enjoyment and performance.',
    'Cooking Skills' => 'Enhance culinary abilities and cooking techniques to prepare delicious and healthy meals.'
  },
  'Project Completion' => {
    'Project Planning' => 'Plan and organize projects, including defining goals, tasks, deadlines, and resources required.',
    'Milestone Tracking' => 'Track progress towards project milestones to ensure timely completion and alignment with goals.',
    'Task Delegation' => 'Delegate tasks and responsibilities to team members effectively to distribute workload and optimize efficiency.',
    'Deadlines Management' => 'Manage project deadlines by setting realistic timelines, monitoring progress, and adjusting schedules as needed.',
    'Project Documentation' => 'Document project details, progress, and outcomes to facilitate communication, evaluation, and future reference.'
  },
  'Fitness and Exercise' => {
    'Cardiovascular Fitness' => 'Improve cardiovascular health and endurance through activities such as running, cycling, or swimming.',
    'Strength Training' => 'Build muscle strength and improve overall fitness through resistance training exercises using weights or bodyweight.',
    'Flexibility and Mobility' => 'Increase flexibility and mobility through stretching exercises to improve range of motion and prevent injury.',
    'Endurance Training' => 'Develop endurance and stamina through prolonged aerobic activities such as long-distance running or cycling.',
    'Sport-specific Training' => 'Train for specific sports or athletic events by focusing on skills, techniques, and conditioning relevant to the sport.'
  },
  'Healthy Habits' => {
    'Hydration' => 'Maintain adequate hydration by drinking water throughout the day to support overall health and well-being.',
    'Nutrition Planning' => 'Plan balanced and nutritious meals that provide essential nutrients to fuel the body and promote optimal health.',
    'Meal Prepping' => 'Prepare meals in advance to save time, reduce stress, and make healthier eating choices throughout the week.',
    'Sleep Hygiene' => 'Establish and maintain healthy sleep habits and a consistent sleep schedule to improve sleep quality and overall health.',
    'Stress Management' => 'Manage stress levels through relaxation techniques, mindfulness practices, and healthy coping strategies.'
  },
  'Reading and Learning' => {
    'Fiction Books' => 'Explore imaginative stories, characters, and themes through reading fiction books for entertainment and enrichment.',
    'Non-fiction Books' => 'Gain knowledge and insights on various topics through reading non-fiction books, including biographies, history, science, and more.',
    'Online Courses' => 'Enroll in online courses to acquire new skills, expand knowledge, and pursue personal or professional development goals.',
    'Podcasts' => 'Listen to podcasts on diverse subjects to learn, stay informed, and be entertained while on the go or during leisure time.',
    'Articles and Essays' => 'Read articles and essays on a wide range of topics to stay updated, explore new ideas, and deepen understanding.'
  },
  'Financial Planning' => {
    'Budget Creation' => 'Create a budget to manage finances effectively by tracking income, expenses, and savings goals.',
    'Expense Tracking' => 'Monitor spending habits and track expenses to identify areas for saving money and reduce unnecessary costs.',
    'Saving Goals' => 'Set financial goals for saving money, building an emergency fund, or achieving long-term financial objectives.',
    'Debt Reduction' => 'Develop a plan to pay off debt systematically and reduce financial burdens by managing debt effectively.',
    'Investment Planning' => 'Plan and strategize investments to grow wealth, build financial security, and achieve future financial goals.'
  },
  'Organization and Decluttering' => {
    'Home Organization' => 'Organize living spaces, including rooms, closets, and storage areas, to create a tidy and functional environment.',
    'Workspace Organization' => 'Organize workspaces, desks, and office supplies to increase productivity, reduce clutter, and enhance focus.',
    'Digital Decluttering' => 'Declutter digital devices, files, and digital spaces to improve organization, efficiency, and digital well-being.',
    'Minimalism' => 'Embrace minimalist lifestyle principles to simplify possessions, reduce materialism, and focus on what truly matters.',
    'Paper Management' => 'Manage paper clutter by organizing documents, files, and paperwork to streamline workflows and reduce paper waste.'
  },
  'Professional Development' => {
    'Networking' => 'Build professional relationships and expand professional networks to gain opportunities, insights, and support.',
    'Resume Building' => 'Create or update resumes to highlight skills, experiences, and achievements for job applications and career advancement.',
    'Job Search Strategies' => 'Develop effective job search strategies, including identifying opportunities, applying for positions, and preparing for interviews.',
    'Skill Enhancement' => 'Enhance skills and competencies through training, workshops, certifications, or self-directed learning to advance career goals.',
    'Career Advancement' => 'Advance career goals by setting objectives, seeking growth opportunities, and taking proactive steps to progress professionally.'
  },
  'Goal Setting and Achievement' => {
    'SMART Goals' => 'Set SMART goals that are Specific, Measurable, Achievable, Relevant, and Time-bound to increase clarity, motivation, and success.',
    'Action Planning' => 'Create action plans outlining specific steps, resources, and timelines needed to achieve goals effectively and efficiently.',
    'Progress Monitoring' => 'Monitor progress towards goals regularly, track milestones, and adjust strategies as needed to stay on course and make progress.',
    'Motivation Techniques' => 'Use various motivation techniques, such as rewards, incentives, accountability, and visualization, to stay motivated and focused on goals.',
    'Celebrating Successes' => 'Acknowledge and celebrate achievements, milestones, and progress towards goals to maintain motivation, boost morale, and sustain momentum.'
  }
}

tasks = [
  'Create detailed plan for goal.',
  'Break goal into smaller tasks.',
  'Set deadlines for tasks.',
  'Prioritize tasks.',
  'Allocate time slots.',
  'Identify obstacles and strategies.',
  'Seek resources and support.',
  'Regularly review progress.',
  'Minimize distractions.',
  'Celebrate milestones.',
  'Stay committed and persistent.',
  'Seek feedback for improvement.',
  'Stay organized and track progress.',
  'Take breaks and prioritize self-care.',
  'Visualize success and long-term vision.',
  'Stay adaptable and open to change.',
  'Learn from failures and setbacks.',
  'Stay accountable and seek support.',
  'Reflect on progress and lessons.',
  'Practice patience and perseverance.',
  'Seek inspiration from role models.',
  'Maintain positivity and growth mindset.',
  'Stay disciplined and stick to commitments.',
  'Stay proactive and take initiative.',
  'Practice time management techniques.',
  'Stay informed and seek new knowledge.',
  'Establish routines that support goal.',
  'Stay flexible and adjust approach.',
  'Stay balanced and prioritize well-being.'
]


user1 = User.create!(first_name: 'sema',
                     last_name: 'karan',
                     email: 'hello.sema@gmail.com',
                     password: '1234test'
                    )

# Select a random category
random_category = categories.keys.sample

# Retrieve the hash of subcategories and descriptions corresponding to the random category
subcategories_with_descriptions = categories[random_category]

# Select a random subcategory and its description from the hash
random_subcategory, random_description = subcategories_with_descriptions.to_a.sample

goal1 = Goal.new(category: random_category,
                     sub_category: random_subcategory,
                     description: random_description,
                     offline: false,
                     online: true,
                    )

goal2 = Goal.new(category: random_category,
                     sub_category: random_subcategory,
                     description: random_description,
                     offline: false,
                     online: true
                     )

goal1.user = user1
goal2.user = user1
goal1.save
goal2.save

puts "user1 is created"

user2 = User.create!(first_name: 'Loes',
                     last_name: 'van Puijenbroek',
                     email: 'hello.Loes@gmail.com',
                     password: '1234test'
                    )

random_category = categories.keys.sample
subcategories_with_descriptions = categories[random_category]
random_subcategory, random_description = subcategories_with_descriptions.to_a.sample

goal1 = Goal.new(category: random_category,
                     sub_category: random_subcategory,
                     description: random_description,
                     offline: false,
                     online: true,
                    )

goal2 = Goal.new(category: random_category,
                     sub_category: random_subcategory,
                     description: random_description,
                     offline: false,
                     online: true
                     )

goal1.user = user2
goal2.user = user2
goal1.save
goal2.save

puts "user2 is created"

user3 = User.create!(first_name: 'Allison',
                     last_name: 'Chen',
                     email: 'hello.Allison@gmail.com',
                     password: '1234test'
                    )

random_category = categories.keys.sample
subcategories_with_descriptions = categories[random_category]
random_subcategory, random_description = subcategories_with_descriptions.to_a.sample

goal1 = Goal.new(category: random_category,
                      sub_category: random_subcategory,
                      description: random_description,
                      offline: false,
                      online: true,
                    )

goal2 = Goal.new(category: random_category,
                      sub_category: random_subcategory,
                      description: random_description,
                      offline: false,
                      online: true
                      )

goal1.user = user3
goal2.user = user3
goal1.save
goal2.save

puts "user3 is created"

user4 = User.create!(first_name: 'Heiddis',
                     last_name: 'Birta',
                     email: 'hello.Heiddis@gmail.com',
                     password: '1234test'
                    )

random_category = categories.keys.sample
subcategories_with_descriptions = categories[random_category]
random_subcategory, random_description = subcategories_with_descriptions.to_a.sample

goal1 = Goal.new(category: random_category,
                      sub_category: random_subcategory,
                      description: random_description,
                      offline: false,
                      online: true,
                    )

goal2 = Goal.new(category: random_category,
                      sub_category: random_subcategory,
                      description: random_description,
                      offline: false,
                      online: true
                      )

goal1.user = user4
goal2.user = user4
goal1.save
goal2.save

puts "user4 is created"

puts "craeting match data..."

match1 = Match.new(status: "not started")
match1.user = user1
match1.goal = user1.goals.first
match1.save

puts "match1 is created"

match2 = Match.new(status: "in progress")
match2.user = user2
match2.goal = user2.goals.first
match2.save

puts "match2 is created"

match3 = Match.new(status: "completed")
match3.user = user3
match3.goal = user3.goals.first
match3.save

puts "match3 is created"

match4 = Match.new(status: "not started")
match4.user = user4
match4.goal = user4.goals.first
match4.save

puts "match4 is created"

puts "creating sample tasks for each match..."


sample_task = tasks.sample
task1 = Task.new(description: sample_task, status: [true, false].sample)
task2 = Task.new(description: sample_task, status: [true, false].sample)
task3 = Task.new(description: sample_task, status: [true, false].sample)
task1.match = match1
task2.match = match1
task3.match = match1
task1.user = user1
task2.user = user1
task3.user = user1
task1.save
task2.save
task3.save

task4 = Task.new(description: sample_task, status: [true, false].sample)
task5 = Task.new(description: sample_task, status: [true, false].sample)
task6 = Task.new(description: sample_task, status: [true, false].sample)
task4.match = match2
task5.match = match2
task6.match = match2
task4.user = user2
task5.user = user2
task6.user = user2
task4.save
task5.save
task6.save

task7 = Task.new(description: sample_task, status: [true, false].sample)
task8 = Task.new(description: sample_task, status: [true, false].sample)
task9 = Task.new(description: sample_task, status: [true, false].sample)
task7.match = match3
task8.match = match3
task9.match = match3
task7.user = user3
task8.user = user3
task9.user = user3
task7.save
task8.save
task9.save

task10 = Task.new(description: sample_task, status: [true, false].sample)
task11 = Task.new(description: sample_task, status: [true, false].sample)
task12 = Task.new(description: sample_task, status: [true, false].sample)
task10.match = match4
task11.match = match4
task12.match = match4
task10.user = user4
task11.user = user4
task12.user = user4
task10.save
task11.save
task12.save

puts "tasks created"
puts "Seeding is done!"
