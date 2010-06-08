# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'iconv'

filename = 'ghdop'

input = filename + '.txt'
output = filename + '.html'

#input = 'prombez.txt'
#output = 'prombez.html'

class Question
  def initialize (text)

    @plainText = text

    @plainText =~ /^Вопрос\s*(\d*)\s*$\n(.*)\nКол-во.*\n(\d*)\s*\n(Ответ\s*1.*)/m

    @number = $1.to_i
    @title = $2
    @answersCount = $3.to_i
    answers = $4

    answer_start = 0
    @answers = Array.new
    @answersCorrect = Array.new
    while true
      answer_start = answers.index("Ответ", answer_start)
      answer_end = answers.index("Ответ", answer_start+1)

      answer_end = -1 if answer_end == nil

      answer = answers [answer_start..answer_end]

      ans_lines = answer.split("\n")
      ans_title = ans_lines[1..-3]
      ans_correct = ans_lines[-2].to_i == 1

      @answers.insert(-1, ans_title.to_s);
      @answersCorrect.insert(-1, ans_correct);

      break if (answer_end == -1)

      answer_start = answer_end
    end

  end

  def out_text
    result = ""
    result += "<h3>" + "<u>Вопрос №%d</u>&nbsp;&nbsp;&nbsp;" % @number + @title + "</h3>\n"
    result += "<ul>\n"
    for i in (0..@answersCount-1)
      correct = @answersCorrect[i]
      if correct
        result += "<li><b><u>" + @answers[i] + "</u></b></li>\n"
      else
        result += "<li>" + @answers[i] + "</li>\n"
      end
    end
    result += "</ul>\n"
    return result
  end

end

class Storage

  def initialize (file)
    contents = file.read
    contents = Iconv.iconv('utf8', 'cp1251', contents).to_s

    question_start = 0

    @questions = Array.new

    while true do
      question_start = contents.index("Вопрос", question_start)
      question_end = contents.index("Вопрос", question_start+1)

      question_end = -1 if question_end == nil

      question = Question.new(contents[question_start..question_end])

      @questions.insert(-1, question)

      break if question_end == -1

      question_start = question_end
    end

    def write_file (filename)
      out_file = File.open(filename, "w")
      out_file.puts "<html><body>"
      @questions.each do |question|
        out_file.puts question.out_text
      end
      out_file.puts "</body></html>"
      out_file.close
    end

    def write
      out = "<html><body>"
      @questions.each do |question|
        out += question.out_text
      end
      out += "</body></html>"
      return out
    end

  end
end

#puts ARGV

#st = Storage.new(input)
#st.write_file(output)

#puts "Successfully converted %s to %s." % [input, output]



class IdoWebController < ApplicationController
  def Input
  end

  def Output
     file = params[:source]
     st = Storage.new(file)
     @a = st.write
  end

end
