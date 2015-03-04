headers:

    ========    h1
    --------    h2
    # h1
    ## h2
    ### h3
    #### h4
    ##### h5
    ###### h6
    
paragraphs:

    \n\n    a new paragraph
    
new line:
	
	add two or more spaces in the end of line
    
blockquotes:

    >

emphasis:

    *xxx*
    _xxx_
    **yyy**
    __yyy__

lists:

    Unordered:
        *
        *
        *
        +
        +
        +
        -
        -
        -
    Ordered:
        1. 
        2. 
        3. 

links:

    [xxx](http://example.com/ "title")
    [xxx][1]

    [1]: http://google.com/    "Google"

images:

    ![alt text](/path/to/img.jpg "Title")
    ![alt text][id]

    [id]: /path/to/img.jpg "Title"

code:

    `xxx`
    or using a tab

Directly insert html tags

Restrictions(block-level html elements):

    <div>, <table>, <pre>, <p>, etc.Must be separated from surrounding content by blank lines, and the start and end tags of the block should not be intended with tabs or spaces.
