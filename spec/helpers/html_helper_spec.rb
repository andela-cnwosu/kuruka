# frozen_string_literal: true
require 'rails_helper'

RSpec.describe HtmlHelper, type: :helper do
  describe HtmlHelper do
    describe '#convert_to_html_class' do
      it 'returns a string separated by hyphen' do
        expect(helper.convert_to_html_class('first class')).to eq('first-class')
      end
    end
  end
end
