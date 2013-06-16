# == Schema Information
#
# Table name: submissions
#
#  id                   :integer          not null,  primary key, auto_increment
#  title                :string
#  description          :text
#  status               :string
#  active               :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not nullclass Submission < ActiveRecord::Base

  STATUS_KINDS = {:draft => "draft", :complete=>"complete", :whole => "whole"}
  TYPE = ['project', 'product']
  
  attr_accessible :user_id, :active, :description, :status, :title,
  								:product_spec_attributes, :project_spec_attributes, :company_attributes, :contact_attributes, :pictures_attributes, :submission_categories_attributes

  belongs_to :user

  has_one :product_spec, :dependent => :destroy
  has_one :project_spec, :dependent => :destroy
  has_one :company, :dependent => :destroy
  has_one :contact, :dependent => :destroy

  
  has_many :submission_categories
  has_many :categories, :through => :submission_categories

  has_many :order_submission
  has_many :orders, :through => :order_submission

  has_many :pictures, :as => :imageable, :dependent => :destroy

  
  scope :whole_submissions, where( :status => STATUS_KINDS[:whole])


	accepts_nested_attributes_for :product_spec, :allow_destroy=>true, :reject_if => :all_blank
	accepts_nested_attributes_for :project_spec, :allow_destroy=>true, :reject_if => :all_blank	
  accepts_nested_attributes_for :company, :allow_destroy=>true, :reject_if => :all_blank
  accepts_nested_attributes_for :contact, :allow_destroy=>true, :reject_if => :all_blank
  accepts_nested_attributes_for :pictures, :allow_destroy=>true, :reject_if => :all_blank
  accepts_nested_attributes_for :submission_categories, :allow_destroy=>true, :reject_if => proc{ |a| a['category_id'] == '-1' }
  
  #validates_associated :company, :contact
  validates :title, :length =>{:maximum =>50}, :presence => true


  def last_image_url(type)
    self.pictures.last.image.url(type) unless self.pictures.last.nil?
  end

  def type
    self.categories.first.kind == 0 ? "product" : "project"
  end
end
