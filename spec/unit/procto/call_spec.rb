# encoding: utf-8

require 'spec_helper'

describe Procto, '.call' do
  subject { klass.call(text) }

  context 'with no name' do
    include_context 'procto'

    let(:klass) do
      Class.new do
        include Procto.call

        def initialize(text)
          @text = text
        end

        def call
          "Hello #{@text}"
        end
      end
    end
  end

  context 'with a name' do
    include_context 'procto'

    let(:name) { double('name', to_sym: :print) }

    let(:klass) do
      method_name = name
      Class.new do
        include Procto.call(method_name)

        def initialize(text)
          @text = text
        end

        def print
          "Hello #{@text}"
        end
      end
    end
  end
end

describe Procto, '.call' do
  subject { klass.call(user: 'user', name: 'name') }

  context 'with kwargs' do
    let(:klass) do
      Class.new do
        include Procto.call

        def initialize(user:, name:, city: nil)
          @user = user
          @name = name
          @city = city
        end

        def call
          "Hello #{@name}, you are #{@user} from #{@city}"
        end
      end
    end

    it 'works' do
      expect(subject).to eq 'Hello name, you are user from '
    end
  end
end
