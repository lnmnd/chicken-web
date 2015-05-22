(module
    controllers
    (main-page item-page about-page)
  (import chicken scheme)
  (use (only data-structures conc))
  (use (only ports with-output-to-string))
  (use (only utils read-all))
  (use (only spiffy send-response))
  (use (only sxml-transforms SXML->HTML))

  ;; sxml-> string
  (define (build-page content)
    (with-output-to-string
      (lambda ()
	(SXML->HTML
	 `(html (head
		 (style ,(read-all "style.css")))
		(body
		 (head (strong "chicken web") ": " (a (@ (href "/")) "index")
		       " "
		       (a (@ (href "/about")) "about"))
		 ,content))))))

  ;; sxml -> response
  (define (sxml->response sxml)
    (send-response
     body: (build-page sxml)))

  (define (li-item x)
    `(li (a (@ (href ,(conc "/item/" x))) ,x)))
    
  (define (main-page)
    (let ((items '(1 2 3 4)))
      (lambda (c)
	(sxml->response
	 `(div (h2 "main page")
	       (ul ,(map li-item items)))))))

  (define (item-page)
    (lambda (c item)
      (sxml->response
       `(div (h2 (conc "item " ,item))
	     (p "item stuff")))))

  (define (about-page)
    (lambda (c)
      (sxml->response
       `(div (h2 "about page")
	     (p "about stuff")))))

  )
