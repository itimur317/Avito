Архитектура — **MVC**

- Темная тема
- Парсинг с использованием DTO-моделей
- Сетевые запросы с использованием completion handler

При запуске начинается загрузка списка товаров (без изображений) и отображается полученная коллекция (через ProductListViewController). Затем при каждом подгруженном изображении обновляется коллекция товаров.
При клике на один из товаров происходит переход на страничку деталей товара (ProductDetailsViewController). Аналогично списку товаров, при подгрузке деталей товара отображается информация о нем, затем при подгрузке изображения отображается и информация с изображением. На страничке деталей есть кнопки, позволяющие скопировать в буфер обмена номер телефона и почту владельца товара.

Оба вьюконтроллера (ProductListViewController, ProductDetailsViewController) используют ErrorDisplayable, LoadingDisplayable свойства (инициализируемые в init) для отображения ошибок и загрузки при сетовом запросе.

Используется класс DependencyContainer для внедрения зависимостей, в т.ч. ErrorDisplayable, LoadingDisplayable, NetworkManager и используемые в нем классы.

<img src="https://github.com/itimur317/Avito/assets/56135499/5424235a-ed9d-4772-9584-210ec6d3f66b.png" width=24% height=22%>
<img src="https://github.com/itimur317/Avito/assets/56135499/0fbddb6b-c2fb-40f1-bb89-e4c7e5a10474.png" width=24% height=22%>
<img src="https://github.com/itimur317/Avito/assets/56135499/1ae9b27c-7bdc-4e8d-ae87-3a5816999550.png" width=24% height=22%>
<img src="https://github.com/itimur317/Avito/assets/56135499/2caadd42-788e-410e-816a-6e8d1a00d811.png" width=24% height=22%>
