from django.urls import path
from . import views
from rest_framework.urlpatterns import format_suffix_patterns as f

app_name = 'album'

urlpatterns = [
    path('showall/', views.showall, name='showall'),
    path('upload/', views.upload, name='upload'),
    path('Imageapi/', views.ImageList.as_view()),
    path('Imageapi/<int:pk>/', views.ImageDetail.as_view()),
]