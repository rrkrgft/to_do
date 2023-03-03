# テーブル一覧
| model | column | data-type |
| --- | --- | ---|
| User | name | string |
| User | email | string |
| User | password_digest | string |
| User | admin | boolean |
| Task | title | string |
| Task | content | text |
| Task | deadline | date |
| Task | status | string |
| Task | priority | string |
| Task | User_id | references |
| Label | ? |  |
| Sort | Task_id | references |
| Sort | Label_id | references |

Herokuデプロイ手順  
1.heroku createのコマンドをターミナルで実行  
2.Gemfileに以下のgemを追加  
*net-smtp  
*net-imap  
*net-pop  
3.git add .のコマンドをターミナルで実行  
4.git commit -m ""のコマンドをターミナルで実行  
5.git push heroku step2のコマンドをターミナルで実行  
6.heroku run rails db:migrate  