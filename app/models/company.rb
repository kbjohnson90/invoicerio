class Company < ActiveRecord::Base
  has_one :user, inverse_of: :company

  has_many :issued_invoices,    :class_name => 'Invoice', :foreign_key => 'issued_by_company_id'
  has_many :received_invoices,  :class_name => 'Invoice', :foreign_key => 'issued_to_company_id'

  def get_invoices_by_page(page)
    # To get the first page, start from index 0
    page_offset = (page-1)*10
    self.issued_invoices.limit(10).offset(page_offset)
  end

   def get_number_of_invoice_pages
    count = (self.issued_invoices.count.to_f / 10).ceil
    if count == 0
      count = 1
    end
    return count
  end
end
