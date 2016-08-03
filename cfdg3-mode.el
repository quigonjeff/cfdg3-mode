;;; cfdg3-model.el --- Major mode for Context Free Design Grammar files.

;; Author: Jefferson O. Andrade <quigonjeff@gmail.com>
;; Keywords: languages; context free; cfdg; major mode;
;; Version: 0.1.0

;;; Commentary:

;; Major mode for editing Context-Free Design Grammar version 2 files,
;; usually ending with '.cfdg'.

;; This package provides the following features:
;; * Syntax coloring (via font-lock)

;;; Installation:

;;  put this file into your load path and the following into your ~/.emacs:
;;    (require 'cfdg3-mode)
;;    (autoload `cfdg3-mode "cfdg3-mode" nil t)
;;    (add-to-list 'auto-mode-alist '("\\.cfdg\\'" . cfdg3-mode))

;;; Code:


(defvar cfdg3-mode-hook nil "Hook variable for `cfdg3-mode'.")


(defvar cfdg3-mode-map
  (let ((map (make-keymap)))
    ;; (define-key map "\C-j" 'newline-and-indent)
    map)
  "Keymap for CFDG3 major mode.")


;; Define the several categories of keywords.
(defvar cfdg3-keywords1
  '("startshape" "shape" "rule" "path" "import"))
(defvar cfdg3-keywords2
  '("if" "else" "switch" "case" "loop" "finally" "transform" "clone"))
(defvar cfdg3-config-vars
  '("AllowOverlap" "Alpha" "Background" "BorderDynamic" "BorderFixed"
    "Color" "ColorDepth" "Frame" "FrameTime" "Impure" "MaxNatural"
    "MinimumSize" "Size" "Symmetry" "Tile" "Time"))
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
  (regexp-opt (append cfdg3-keywords1 cfdg-keywords2) 'words))
(defvar cfdg3-constants-re
  (regexp-opt cfdg3-flags 'words))
(defvar cfdg3-types-re
  (regexp-opt (append cfdg3-param-types cfdg3-adjustments) 'words))
(defvar cfdg3-builtins-re
  (regexp-opt (append cfdg3-primitives cfdg3-path-operations) 'words))
(defvar cfdg3-functions-re
  (regexp-opt cfdg3-predef-functions 'words))

(defconst cfdg3-font-lock-keywords-1
  `((,cfdg3-keywords-re . font-lock-keyword-face)
    (,cfdg3-constants-re . font-lock-constant-face)
    (,cfdg3-types-re . font-lock-type-face)
    (,cfdg3-builtins-re . font-lock-builtin-face)
    (,cfdg3-functions-re . font-lock-function-name-face)))


(provide 'cfdg3-mode)
;;; cfdg3-mode ends here

;; Local Variables:
;; ispell-local-dictionary: "english"
;; End:
