(import ssql)

(display (ssql->sql #f '(select (columns id title author) (from books))))
(display "\n")
