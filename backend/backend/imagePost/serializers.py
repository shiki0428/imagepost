from rest_framework import serializers
from imagePost.models import Image
class ImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Image
        fields = ['picture','title']