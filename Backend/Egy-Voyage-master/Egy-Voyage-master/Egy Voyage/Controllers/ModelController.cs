//using EgyVoyageApi.modelE;
//using Microsoft.AspNetCore.Mvc;
//using Microsoft.Extensions.ML;
//using Tensorflow;
//using Tensorflow.NumPy;

//public class ModelController : Controller
//{
//    private readonly PredictionEnginePool<ModelInput, ModelOutput> _predictionEnginePool;
//    private readonly string _modelPath ="D:\\crash course\\LEARNING ASP\\EgyVoyageApi\\EgyVoyageApi\\mobilenet_model.zip";

//    public ModelController(PredictionEnginePool<ModelInput, ModelOutput> predictionEnginePool)
//    {
//        _predictionEnginePool = predictionEnginePool;
//    }

//    [HttpPost]
//    public ActionResult<string> Predict([FromBody] float[] input)
//    {
//        try
//        {
//            // Load the TensorFlow model
//            var model = new tensorflow()

//            // Perform inference
//            var inputData = np.array(input);
//            var output = model(inputData);

//            // Convert output to a readable format (e.g., JSON)
//            var result = output.ToArray<float>();

//            return Ok(result);
//        }
//        catch (Exception ex)
//        {
//            return StatusCode(500, $"An error occurred: {ex.Message}");
//        }
//    }


//    [HttpPost("/imageToString")]
//    public async Task<IActionResult> ImageToString(IFormFile image)
//    {
//        try
//        {
//            // Check if the request contains a file
//            if (image == null)
//            {
//                return BadRequest("No file uploaded.");
//            }

//            // Get the first file from the request
//            var file = Request.Form.Files[0];

//            // Read the content of the file into a MemoryStream
//            using (var memoryStream = new MemoryStream())
//            {
//                await image.CopyToAsync(memoryStream);

//                // Convert the byte array representing the image to a base64 string
//                string imageData = Convert.ToBase64String(memoryStream.ToArray());

//                return Ok(imageData);
//            }
//        }
//        catch (Exception ex)
//        {
//            return StatusCode(StatusCodes.Status500InternalServerError, $"An error occurred: {ex.Message}");
//        }
//    }
//}
