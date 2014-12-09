1. Container class templates:

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

2. Algorithm:

    一般参数为FirstIterator, LastIterator, value(or func)

    或者FirstIterator1, LastIterator1, FirstIterator2, LastIterator2

        std::make_heap(v.begin(), v.end());
        std::pop_heap(v.begin(), v.end()); v.pop_back();//相当于先做Percate down, 将最值移到尾部，然后就可以pop出来
        v.push_back(99); std::push_heap(v.begin(), v.end());//先在尾部插入数据，然后做Percate up，重构堆
        std::sort_heap(v.begin(), v.end());//将目前的堆排序

    std::sort:

    必须保证a < b和b < a不能同时为true

    (a, b) 返回true，表示a排在b的前面
