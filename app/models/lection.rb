class Lection < ApplicationRecord
  has_many :comments, dependent: :destroy
  acts_as_taggable_on :tags
  belongs_to :user, optional: true
  validates :title, uniqueness: { scope: :user_id, message: "must be unique for each of your posts" }
  validates :body,presence: true,length: {maximum: 1500},on: :create,allow_nil: false

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_speciality
    ]
  )
  scope :with_speciality, lambda { |speciality|
     where(speciality: [*speciality])
  }
  scope :search_query, lambda { |query|
    # Searches the students table on the 'first_name' and 'last_name' columns.
    # Matches using LIKE, automatically appends '%' to each term.
    # LIKE is case INsensitive with MySQL, however it is case
    # sensitive with PostGreSQL. To make it work in both worlds,
    # we downcase everything.
    return nil  if query.blank?

    # condition query, parse into individual keywords
    terms = query.to_s.downcase.split(/\s+/)

    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conds = 1
    where(
      terms.map { |term|
        "(LOWER(lections.title) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
case sort_option.to_s
when /^created_at_/
order("lecture_notes.created_at #{ direction }")
when /^title_/
order("LOWER(lecture_notes.title) #{ direction }")
when /^speciality/
order("LOWER(lecture_notes.speciality) #{ direction }")
when /^description/
order("LOWER(lecture_notes.description) #{ direction }")
else
raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
end
}
def self.options_for_sorted_by
    [
      ['Creation date (newest first)', 'created_at_desc'],
      ['Title (a-z)', 'title_asc'],
      ['Speciality (0-9)', 'speciality_asc']
    ]
  end
end
