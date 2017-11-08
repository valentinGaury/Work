#include "opencv2/opencv.hpp"
#include <iostream>
using namespace cv;


int thresh=5;
int main(int, char**)
{
  vector<Vec4i> hierarchy;
  vector<vector<Point> > contours;
    VideoCapture cap(0); // open the default camera
    if(!cap.isOpened())  // check if we succeeded
        return -1;

    Mat edges;
    namedWindow("edges",1);
    for(;;)
    {
        Mat frame;
        cap >> frame; // get a new frame from camera

		for(int i = 0; i < frame.rows; i++)
{
    const double* Mi = frame.ptr<double>(i);
    for(int j = 0; j < frame.cols; j++) {
      int b = (int) frame.at<cv::Vec3b>(i,j)[0];
      int g = (int) frame.at<cv::Vec3b>(i,j)[1];
      int r = (int) frame.at<cv::Vec3b>(i,j)[2];
      if(std::max(r,std::max(g,b))==r && r-std::min(r,std::min(g,b))>= 30){
	frame.at<cv::Vec3b>(i,j)[0]=255;
	frame.at<cv::Vec3b>(i,j)[1]=255;
	frame.at<cv::Vec3b>(i,j)[2]=255;
	 }
    else {
	frame.at<cv::Vec3b>(i,j)[0]=0;
	frame.at<cv::Vec3b>(i,j)[1]=0;
	frame.at<cv::Vec3b>(i,j)[2]=0;

    }

    }}
       
		//findContours(InputOutputArray image, OutputArrayOfArrays contours, OutputArray hierarchy, int mode, int method, Point offset=Point())
		    RNG rng(12345);
		cvtColor(frame, edges, CV_BGR2GRAY);
		  GaussianBlur(edges, edges, Size(5,5), 1.5, 1.5);
		   Canny(edges, edges, 10, 200, 3);
		  findContours( edges, contours, hierarchy, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_NONE, Point(0, 0) );
		   Mat drawing = Mat::zeros( edges.size(), CV_8UC3 );
		   // std::cout << contours.at(2).size() << std::endl ;
		   int tamp;
		    for( int i = 0; i< contours.size(); i++ )
		    {
		      if( contours.at(2).size()<tamp ? 
		    }
		   
        Scalar color = Scalar( 255, 255,255 );
        drawContours( drawing, contours, 1, color, 1, 1, hierarchy, 0, Point() );
	// }     
 
    imshow( "Result window", drawing );
		  // imshow("edges", edges);
	//contours;
	//hierarchy;
        if(waitKey(30) >= 0) break;
    }
    // the camera will be deinitialized automatically in VideoCapture destructor
    return 0;
}

