array = [nil, 1, 2, 3, nil]
# nilを削除して計算
p array.compact.inject(&:+)