#include <iostream>
#include <cstdlib>


#include "ExpData.hpp"
#include "Integrator.hpp"
#include "ModEq.hpp"
#include "OptimizationEngine.hpp"


int main()
{
    try
    {

        std::vector<ExpData> dataSet;

        ExpData::LoadExpData("borovice_buk 5,15,25 dusik.csv", dataSet, 5.0);

        /* for(std::vector<ExpData>::const_iterator it = dataSet.begin(); it != dataSet.end(); ++it)
         {
             std::cout << *it;
         }*/

        OptimizationEngine::Run(&dataSet);

        /*double* modData = new double[dataSet.size()];

        Integrator::Runge23(&dataSet, modData, 5.49e12, 1.70e5, 3.56, 0.231642);

        for(unsigned int i = 0; i < dataSet.size(); i++)
        {
            std::cout << dataSet[i].Time() << "," << dataSet[i].MassFrac() << "," << modData[i] << std::endl;
        }

        delete[] modData;*/
    }
    catch(std::exception& e)
    {
        std::cerr << e.what() << std::endl;

        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
