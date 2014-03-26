Container class templates:
    Sequence containers:
        array(c++11)
        vector
        deque
        list(双向链表)
        forward_list(c++11，单链表)
    iterators: begin, end, rbegin, rend
    const iterators: cbegin, cend, crbegin, crend
    capacity: size, max_size, empty, resize, shrink_to_fit, capacity, reverse
    element access: front, back, operator[], at
    modifiers: assign(赋初值), emplace(构造并且插入元素), insert, erase, emplace_back, push_back, pop_back, emplace_front, push_front, pop_front, clear, swap(交换两个container)

    Container adaptors:
        stack
        queue
        priority_queue
    Associative containers:
        set
        multiset
        map
        multimap
    Unordered associative containers:(c++11)
        unordered_set
        unordered_multiset
        unordered_map
        unordered_multimap
