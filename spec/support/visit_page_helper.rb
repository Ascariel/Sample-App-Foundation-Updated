module VisitPageHelper
	def visit_page(page)
		visit "/static_pages/#{page}"
	end
end