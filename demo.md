# Compiler final project

## .l檔: :cat:
---
- Example:
  1. (syntax error)
      ```
      F = {x^^2}
      ```
  2. (syntax error)
     
     > 我們只有大寫A~Z可以當作函數
      ```
      abc = {2x^4+y^2}
      ```
  3. (syntax error)
      >數學式需用{}括起來
      ```
      F = 2x^4+y^2
      ```
  4. (syntax error)
      >指數不能是負數
      ```
      F = {-2x^-2}
      ```
   
## .y檔: :dog:
---

- 規則: 輸入任意多項式，可連續做多項式運算，直到對變數(x,y,z)賦值，才會輸出結果。
  
- Example:
  0. 全部token都存在，但因為排列錯誤，CFG判斷為error
        ```
        F = {3x^3+2x} +
        ```
  1. variable沒有全部賦值，可得部分解
        ```
        F = {9z^5+x^5+x^4+1}
        z = -1
        x = 1
        ```
  2. 可以連續做函式加法/減法/偏微分

        >可使用函式做運算
        - 加法:
            ```
            F = {2x^5+3x^4+5y^2} + {x^5+x^2+z^4} + {24}
            G = F + {3x^2}
            x = 1
            x = 0
            y = -10
            z = 20  
            ```
        - 減法:
            ```
            F = {2x^5+3x^4+5y^2} - {x^5+x^2+z^4}
            G = {3x^2} - F
            x = 1
            x = 0
            y = -10
            z = 2
            ```
        - 偏微分:
            ```
            F = {2x^100-3x^5+9y^5+5z^1+6}
            G = F |d x
            H = F |d y
            I = F |d z
            K = F|dx |dy |dz
            x = 1
            ```
        - 全部都可以混和運算（優先序: 偏微分較+-優先）
            ```
            F = {2x^4-3x^3} - {x^2+y^4} - {32}
            G = F + {3x^2}
            H = F + G |d x
            x = 0
            ```
            
  3. 沒有定義的函式，會告訴user那些沒有定義，且會跳過那些沒有定義的函式計算結果
        ```
        F = {3x^3+3x^2+3x^1+15}
        I = G + {3x^3+3x^2+3x^1+15} + H + Q + F
        x = 3
        ```
  4. 未排序的、出現重複次方，會合併同類項，並按照次方大小、依x,y,z順序輸出。
        ```
        F = {x^3-x^5-9z^5+2x^5+x^9-x^3}
        y = 1
        ```
  