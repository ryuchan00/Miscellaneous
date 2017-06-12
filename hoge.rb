class Hoge
    def initialize(x, y, z)
        @x = x
        @y = y
        @z = z
    end
    
    def display
        p "x: " + @x.to_s
        p "y: " + @y.to_s
        p "x: " + @z.to_s
    end
end

x, y, z = gets.split.map(&:to_i)
hoge = Hoge.new(x, y, z)
hoge.display
