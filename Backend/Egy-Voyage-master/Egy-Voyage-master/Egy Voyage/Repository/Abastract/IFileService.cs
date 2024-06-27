﻿namespace EgyVoyageApi.Repository.Abastract
{
    public interface IFileService
    {
        public Tuple<int, string> SaveImage(IFormFile imageFile);
        public bool DeleteImage(string imageFileName);
        public IFormFile ConvertToFormFile(byte[] imageBytes, string fileName);
    }
}
