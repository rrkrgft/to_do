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