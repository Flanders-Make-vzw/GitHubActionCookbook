# Use the official Python runtime image
FROM python:3.13-slim  
 
# Create the app directory
RUN mkdir /hello_world_app
 
# Set the working directory inside the container
WORKDIR /hello_world_app
 
# Set environment variables 
# Prevents Python from writing pyc files to disk
# ENV PYTHONDONTWRITEBYTECODE=1
#Prevents Python from buffering stdout and stderr
# ENV PYTHONUNBUFFERED=1 
 
# Upgrade pip
# RUN pip install --upgrade pip 
 
# Copy the Django project  and install dependencies
COPY requirements.txt  /hello_world_app/
 
# run this command to install all dependencies 
RUN pip install --no-cache-dir -r requirements.txt
 
# Copy the Django project to the container
COPY hello_world_app/. /hello_world_app/
 
# Expose the Django port
EXPOSE 8000
 
# Run Django’s development server
# CMD ["python", "manage.py", "runserver", "127.0.0.1:8000"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]