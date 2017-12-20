require 'json'

data = [1, 2.0, {'key' => 'value'}, nil, true, false]

# JSONとしてダンプする
# JSON.dump(data)でも良い

p json = data.to_json 

# ロードする
p JSON.load(json)
