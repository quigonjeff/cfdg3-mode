;;; cfdg3-model.el --- Major mode for Context Free Design Grammar files.

;; Author: Jefferson O. Andrade <quigonjeff@gmail.com>
;; Keywords: languages; context free; cfdg; major mode;
;; Version: 0.1.0 -- see [[http://semver.org/spec/v2.0.0.html]]

;; This file is not part of GNU Emacs.

;;; License:

;; You can redistribute this program and/or modify it under the terms
;; of the GNU General Public License version 3.

;;; Commentary:

;; Major mode for editing Context-Free Design Grammar version 3 files,
;; usually ending with '.cfdg'.

;; This package provides the following features:
;; * Syntax coloring (via font-lock)

;;; Installation:

;;  Put this file into your load path and the following into your ~/.emacs:
;;    (require 'cfdg3-mode)
;;    (autoload 'cfdg3-mode "cfdg3-mode" nil t)
;;    (add-to-list 'auto-mode-alist '("\\.cfdg\\'" . cfdg3-mode))

;;; Code:

;; Define the several categories of keywords.
(defvar cfdg3-keywords1
  '("startshape" "shape" "rule" "path" "import"))
(defvar cfdg3-keywords2
  '("if" "else" "switch" "case" "loop" "finally" "transform" "clone"))
(defvar cfdg3-config-vars
  '("CF::AllowOverlap" "CF::Alpha" "CF::Background" "CF::BorderDynamic"
    "CF::BorderFixed" "CF::Color" "CF::ColorDepth" "CF::Frame"
    "CF::FrameTime" "CF::Impure" "CF::MaxNatural" "CF::MinimumSize"
    "CF::Size" "CF::Symmetry" "CF::Tile" "CF::Time"))
(defvar cfdg3-flags
  '("CF::None" "CF::ArcCW" "CF::ArcLarge" "CF::Continuous" "CF::Align"
    "CF::EvenOdd" "CF::IsoWidth" "CF::MiterJoin" "CF::RoundJoin"
    "CF::BevelJoin" "CF::ButtCap" "CF::RoundCap" "CF::SquareCap"
    "CF::EvenOdd"))
(defvar cfdg3-param-types
  '("number" "vector1" "vector2" "vector3" "vector4" "vector5" "vector6"
    "vector7" "vector8" "vector9" "adjustment" "shape" "natural"))
(defvar cfdg3-operators
  '("<" ">" "<=" ">=" "==" "<>" "!" "&&" "||" "^^" "±" "≠" "≤" "≥"
    "+" "-" "*" "/" "--" "%" "^" ".." "…" "+-" "," ":" "::"))
(defvar cfdg3-predef-functions
  '("abs" "acos" "acosh" "asin" "asinh" "atan" "atan2" "atanh" "bitand"
    "bitleft" "bitnot" "bitor" "bitright" "bitxor" "cos" "cosh" "div"
    "divides" "exp" "factorial" "floor" "frame" "ftime" ;"if"
    "infinity" "isNatural" "let" "log" "log10" "max" "min" "mod" "rand"
    "randint" "select" "sg" "sin" "sinh" "sqrt" "tan" "tanh"))
(defvar cfdg3-adjustments
  '("hue" "h" "saturation" "sat" "brightness" "b" "alpha" "a" "x" "y" "z"
    "size" "s" "rotate" "rot" "r" "flip" "f" "skew" ;"transform"
    "trans" "time" "timescale"))
(defvar cfdg3-primitives
  '("CIRCLE" "TRIANGLE" "SQUARE"))
(defvar cfdg3-path-operations
  '("MOVETO" "LINETO" "ARCTO" "CURVETO"
    "MOVEREL" "LINEREL" "ARCREL" "CURVEREL"
    "CLOSEPOLY" "STROKE" "FILL"))

;; Generate regexps for each keyword category.
(defvar cfdg3-keywords-re
  (regexp-opt (append cfdg3-keywords1 cfdg3-keywords2) 'words))
(defvar cfdg3-config-vars-re
  (regexp-opt cfdg3-config-vars 'words))
(defvar cfdg3-constants-re
  (regexp-opt cfdg3-flags 'words))
(defvar cfdg3-types-re
  (regexp-opt (append cfdg3-param-types cfdg3-adjustments) 'words))
(defvar cfdg3-builtins-re
  (regexp-opt (append cfdg3-primitives cfdg3-path-operations) 'words))
(defvar cfdg3-functions-re
  (regexp-opt cfdg3-predef-functions 'words))
(defvar cfdg3-singleline-comment-re "//.*$")
;; (defvar cfdg3-multiline-comment-re "/\\*\\([^\\*]\\|\\(\\*[^/]\\)\\)*\\*/")

(defconst cfdg3-font-lock-defaults
  `((,cfdg3-singleline-comment-re . font-lock-comment-face)
    ;; (,cfdg3-multiline-comment-re . font-lock-comment-face)
    (,cfdg3-keywords-re . font-lock-keyword-face)
    (,cfdg3-types-re . font-lock-type-face)
    (,cfdg3-builtins-re . font-lock-builtin-face)
    (,cfdg3-config-vars-re . font-lock-builtin-face)
    (,cfdg3-functions-re . font-lock-function-name-face)
    (,cfdg3-constants-re . font-lock-constant-face)
    ))

(defvar cfdg3-tab-width 4 "Default CFDG mode tab width.")

;; define-derived-mode variant parent name docstring keyword-args… body…
(define-derived-mode cfdg3-mode fundamental-mode
  "CFDG"
  "Major mode for editing Context-Free Design Grammar version 3 files."
  (setq-mode-local cfdg3-mode
                   font-lock-defaults '((cfdg3-font-lock-defaults))
                   tab-width cfdg3-tab-width
                   comment-multi-line nil
                   comment-start "/*"
                   comment-end "/*"
                   comment-start-skip "/\\*+[ \t]*"
                   comment-end-skip "[ \t]*\\*+/"
                   ))

(add-to-list 'auto-mode-alist '("\\.cfdg\\'" . cfdg3-mode))

(provide 'cfdg3-mode)
;;; cfdg3-mode ends here

;; Local Variables:
;; ispell-local-dictionary: "english"
;; End:
