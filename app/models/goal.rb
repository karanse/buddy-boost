class Goal < ApplicationRecord
  CATEGORIES = {
    'Productivity and Time Management' => ['Task Management', 'Prioritization', 'Time Blocking', 'Pomodoro Technique', 'Goal Setting'],
    'Skill Development' => ['Programming and Coding', 'Graphic Design', 'Language Learning', 'Music Instrument', 'Cooking Skills'],
    'Project Completion' => ['Project Planning', 'Milestone Tracking', 'Task Delegation', 'Deadlines Management', 'Project Documentation'],
    'Fitness and Exercise' => ['Cardiovascular Fitness', 'Strength Training', 'Flexibility and Mobility', 'Endurance Training', 'Sport-specific Training'],
    'Healthy Habits' => ['Hydration', 'Nutrition Planning', 'Meal Prepping', 'Sleep Hygiene', 'Stress Management'],
    'Reading and Learning' => ['Fiction Books', 'Non-fiction Books', 'Online Courses', 'Podcasts', 'Articles and Essays'],
    'Financial Planning' => ['Budget Creation', 'Expense Tracking', 'Saving Goals', 'Debt Reduction', 'Investment Planning'],
    'Organization and Decluttering' => ['Home Organization', 'Workspace Organization', 'Digital Decluttering', 'Minimalism', 'Paper Management'],
    'Professional Development' => ['Networking', 'Resume Building', 'Job Search Strategies', 'Skill Enhancement', 'Career Advancement'],
    'Goal Setting and Achievement' => ['SMART Goals', 'Action Planning', 'Progress Monitoring', 'Motivation Techniques', 'Celebrating Successes']
  }

  belongs_to :user
  has_one :match

  has_many :tasks, through: :matches
  validates :category, :description, presence: true
end
