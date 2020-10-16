def bubble_sort(array)
  sorted_array = array
  array.map.with_index do |_val, indx|
    i = 0
    if indx < array.length
      while i < array.length - 1

        if array[i] > array[i + 1]
          next_value = array[i + 1]
          array[i + 1] = array[i]
          array[i] = next_value
          sorted_array = array   
        end
        i += 1
      end
    end
  end
  sorted_array
end

def bubble_sort_by(array)
  sorted_array = array
  array.map.with_index do |_val, indx|
    i = 0
    if indx < array.length
      while i < array.length - 1
        if yield(array[i], array[i + 1]).positive?
          next_value = array[i + 1]
          array[i + 1] = array[i]
          array[i] = next_value
          sorted_array = array
        end
        i += 1
      end
    end
  end
  sorted_array
end

bubble_sort_by(%w[hello hey hi here]) do |left, right|
  left.length - right.length
end
